const card = document.getElementById('currentCard');
const cardStack = document.getElementById('cardStack');
const likeIndicator = document.getElementById('likeIndicator');
const nopeIndicator = document.getElementById('nopeIndicator');
const infoBtn = document.getElementById('infoBtn');
const infoPanel = document.getElementById('infoPanel');
const closeBtn = document.getElementById('closeBtn');
const rejectBtn = document.getElementById('rejectBtn');
const acceptBtn = document.getElementById('acceptBtn');
const noMore = document.getElementById('noMore');
const actionButtons = document.getElementById('actionButtons');

let isDragging = false;
let startX = 0;
let currentX = 0;
const THRESHOLD = 100;

card.addEventListener('mousedown', (e) => {
    if (infoPanel.classList.contains('visible')) return;
    isDragging = true;
    startX = e.clientX;
    card.style.transition = 'none';
});

document.addEventListener('mousemove', (e) => {
    if (!isDragging) return;
    currentX = e.clientX - startX;
    const rotate = currentX * 0.08;
    card.style.transform = `translateX(${currentX}px) rotate(${rotate}deg)`;

    if (currentX > 30) {
    likeIndicator.style.opacity = Math.min(currentX / THRESHOLD, 1);
    nopeIndicator.style.opacity = 0;
    } else if (currentX < -30) {
    nopeIndicator.style.opacity = Math.min(-currentX / THRESHOLD, 1);
    likeIndicator.style.opacity = 0;
    } else {
    likeIndicator.style.opacity = 0;
    nopeIndicator.style.opacity = 0;
    }
});

document.addEventListener('mouseup', () => {
    if (!isDragging) return;
    isDragging = false;

    if (currentX > THRESHOLD) {
    flyOff('right');
    } else if (currentX < -THRESHOLD) {
    flyOff('left');
    } else {
    card.style.transition = 'transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
    card.style.transform = 'translateX(0) rotate(0deg)';
    likeIndicator.style.opacity = 0;
    nopeIndicator.style.opacity = 0;
    }
    currentX = 0;
});

rejectBtn.addEventListener('click', () => flyOff('left'));
acceptBtn.addEventListener('click', () => flyOff('right'));

function flyOff(direction) {
    const x = direction === 'right' ? 1200 : -1200;
    const rotate = direction === 'right' ? 30 : -30;
    card.style.transition = 'transform 0.5s ease, opacity 0.5s ease';
    card.style.transform = `translateX(${x}px) rotate(${rotate}deg)`;
    card.style.opacity = '0';
    likeIndicator.style.opacity = 0;
    nopeIndicator.style.opacity = 0;

    // TODO: swap this for real Flask POST when wiring up
    // const userId = card.dataset.id;
    // fetch('/swipe', {
    //   method: 'POST',
    //   headers: { 'Content-Type': 'application/json' },
    //   body: JSON.stringify({ swiped_id: userId, direction: direction })
    // });

    setTimeout(() => {
    cardStack.style.display = 'none';
    actionButtons.style.display = 'none';
    noMore.style.display = 'flex';
    }, 500);
}

infoBtn.addEventListener('click', () => infoPanel.classList.add('visible'));
closeBtn.addEventListener('click', () => infoPanel.classList.remove('visible'));