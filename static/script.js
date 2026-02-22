const cardStack = document.getElementById('cardStack');
const noMore = document.getElementById('noMore');
const actionButtons = document.getElementById('actionButtons');
const rejectBtn = document.getElementById('rejectBtn');
const acceptBtn = document.getElementById('acceptBtn');

let cards = Array.from(document.querySelectorAll('.card'));
let currentIndex = cards.length - 1;

function getTopCard() {
  return cards[currentIndex];
}

function getIndicators(card) {
  return {
    like: card.querySelector('.like-indicator'),
    nope: card.querySelector('.nope-indicator'),
    infoBtn: card.querySelector('.info-btn'),
    infoPanel: card.querySelector('.info-panel'),
    closeBtn: card.querySelector('.close-btn')
  };
}

let isDragging = false;
let startX = 0;
let currentX = 0;
const THRESHOLD = 100;

document.addEventListener('mousedown', (e) => {
  const card = getTopCard();
  if (!card || !card.contains(e.target)) return;
  const { infoPanel } = getIndicators(card);
  if (infoPanel.classList.contains('visible')) return;
  isDragging = true;
  startX = e.clientX;
  card.style.transition = 'none';
});

document.addEventListener('mousemove', (e) => {
  if (!isDragging) return;
  const card = getTopCard();
  const { like, nope } = getIndicators(card);
  currentX = e.clientX - startX;
  card.style.transform = `translateX(${currentX}px) rotate(${currentX * 0.08}deg)`;
  if (currentX > 30) {
    like.style.opacity = Math.min(currentX / THRESHOLD, 1);
    nope.style.opacity = 0;
  } else if (currentX < -30) {
    nope.style.opacity = Math.min(-currentX / THRESHOLD, 1);
    like.style.opacity = 0;
  } else {
    like.style.opacity = 0;
    nope.style.opacity = 0;
  }
});

document.addEventListener('mouseup', () => {
  if (!isDragging) return;
  isDragging = false;
  const card = getTopCard();
  const { like, nope } = getIndicators(card);
  if (currentX > THRESHOLD) {
    flyOff('right');
  } else if (currentX < -THRESHOLD) {
    flyOff('left');
  } else {
    card.style.transition = 'transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
    card.style.transform = 'translateX(0) rotate(0deg)';
    like.style.opacity = 0;
    nope.style.opacity = 0;
  }
  currentX = 0;
});

rejectBtn.addEventListener('click', () => flyOff('left'));
acceptBtn.addEventListener('click', () => flyOff('right'));

function flyOff(direction) {
  const card = getTopCard();
  console.log('card id:', card.dataset.id);
  console.log('direction:', direction);
  const { like, nope } = getIndicators(card);
  const x = direction === 'right' ? 1200 : -1200;
  const rotate = direction === 'right' ? 30 : -30;
  card.style.transition = 'transform 0.5s ease, opacity 0.5s ease';
  card.style.transform = `translateX(${x}px) rotate(${rotate}deg)`;
  card.style.opacity = '0';
  like.style.opacity = 0;
  nope.style.opacity = 0;

  const userId = card.dataset.id;
  fetch('/Match', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({swiped_id: userId, direction: direction})
  });

  setTimeout(() => {
    card.remove();
    currentIndex--;
    if (currentIndex < 0) {
      cardStack.style.display = 'none';
      actionButtons.style.display = 'none';
      noMore.style.display = 'flex';
    }
  }, 500);
}

// Info panel — attach to each card
cards.forEach(card => {
  const { infoBtn, infoPanel, closeBtn } = getIndicators(card);
  infoBtn.addEventListener('click', () => infoPanel.classList.add('visible'));
  closeBtn.addEventListener('click', () => infoPanel.classList.remove('visible'));
});