-- Roommate Finder - Seed Data (50 Users)
-- Run with: sqlite3 roommates.db < seed_users.sql

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER,
    year TEXT,
    major TEXT,
    profile_pic TEXT,
    sleep_schedule TEXT,       -- 'early_riser', 'night_owl', 'flexible'
    living_preference TEXT,    -- 'on_campus', 'off_campus', 'no_preference'
    building_preference TEXT,  -- dorm/area name or NULL
    rent_min INTEGER,
    rent_max INTEGER,
    cleanliness INTEGER,       -- 1 (messy) to 5 (very clean)
    num_bedrooms INTEGER,
    num_bathrooms INTEGER,
    bio TEXT
);

CREATE TABLE IF NOT EXISTS swipes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    swiper_id INTEGER,
    swiped_id INTEGER,
    direction TEXT,            -- 'accept' or 'reject'
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (swiper_id) REFERENCES users(id),
    FOREIGN KEY (swiped_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS matches (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user1_id INTEGER,
    user2_id INTEGER,
    compatibility_score INTEGER,
    compatibility_reason TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user1_id) REFERENCES users(id),
    FOREIGN KEY (user2_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS messages (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    match_id INTEGER,
    sender_id INTEGER,
    content TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (sender_id) REFERENCES users(id)
);

-- =====================
-- INSERT 50 USERS
-- =====================

INSERT INTO users (name, age, year, major, profile_pic, sleep_schedule, living_preference, building_preference, rent_min, rent_max, cleanliness, num_bedrooms, num_bathrooms, bio) VALUES
('Aiden Park', 19, 'Freshman', 'Computer Science', 'https://i.pravatar.cc/150?img=1', 'night_owl', 'on_campus', 'Ehringhaus', 500, 800, 3, 1, 1, 'Chill CS guy who loves gaming and late night coding sessions. Looking for someone low-key.'),
('Maya Patel', 20, 'Sophomore', 'Biology', 'https://i.pravatar.cc/150?img=2', 'early_riser', 'on_campus', 'Craige', 500, 750, 5, 1, 1, 'Pre-med and very studious. I keep my space spotless and prefer quiet hours after 10pm.'),
('Jordan Ellis', 21, 'Junior', 'Psychology', 'https://i.pravatar.cc/150?img=3', 'flexible', 'off_campus', 'Chapel Hill downtown', 700, 1000, 3, 2, 1, 'Social but respectful of space. Love cooking and hosting small get-togethers on weekends.'),
('Priya Sharma', 22, 'Senior', 'Economics', 'https://i.pravatar.cc/150?img=4', 'early_riser', 'off_campus', 'Carrboro', 600, 900, 4, 2, 2, 'Organized and driven. Looking for a roommate who respects shared spaces and quiet study time.'),
('Caleb Johnson', 18, 'Freshman', 'Political Science', 'https://i.pravatar.cc/150?img=5', 'night_owl', 'on_campus', 'Granville Towers', 500, 800, 2, 1, 1, 'First year figuring things out. I like music, debate, and staying up way too late.'),
('Sofia Nguyen', 20, 'Sophomore', 'Journalism', 'https://i.pravatar.cc/150?img=6', 'flexible', 'off_campus', 'Franklin Street area', 650, 950, 4, 2, 1, 'Writer and coffee addict. I work from home a lot so prefer someone who keeps things tidy.'),
('Marcus Webb', 21, 'Junior', 'Business', 'https://i.pravatar.cc/150?img=7', 'early_riser', 'off_campus', 'Carrboro', 700, 1100, 3, 2, 2, 'Finance bro but chill. Up at 6am for runs, in bed by 11. Looking for similar energy.'),
('Aisha Thompson', 19, 'Freshman', 'Nursing', 'https://i.pravatar.cc/150?img=8', 'early_riser', 'on_campus', 'Craige', 500, 750, 5, 1, 1, 'Nursing student so I keep weird hours sometimes. Very clean, very quiet. Need the same.'),
('Ethan Rivera', 22, 'Senior', 'Computer Science', 'https://i.pravatar.cc/150?img=9', 'night_owl', 'off_campus', 'Eastgate area', 700, 1000, 3, 2, 1, 'Senior dev building side projects. WFH often, so I need good wifi and a quiet space.'),
('Lily Chen', 20, 'Sophomore', 'Art History', 'https://i.pravatar.cc/150?img=10', 'flexible', 'on_campus', 'Morrison', 500, 750, 4, 1, 1, 'Artsy and introverted. I love quiet evenings, candles (safe ones!), and thrifting on weekends.'),
('Noah Kim', 21, 'Junior', 'Chemistry', 'https://i.pravatar.cc/150?img=11', 'night_owl', 'off_campus', 'Carrboro', 650, 950, 4, 2, 1, 'Chem major always in the lab. Home late but very respectful. No parties at the apartment please.'),
('Zoe Martinez', 19, 'Freshman', 'English', 'https://i.pravatar.cc/150?img=12', 'flexible', 'on_campus', 'Ehringhaus', 500, 800, 3, 1, 1, 'Book lover, aspiring novelist. Looking for someone chill who does not mind music while studying.'),
('Liam Foster', 22, 'Senior', 'Philosophy', 'https://i.pravatar.cc/150?img=13', 'night_owl', 'off_campus', 'Franklin Street area', 700, 1050, 2, 2, 1, 'Deep thinker, light cleaner. I keep common areas fine but my room is my own chaos. Fair warning.');
-- ('Nia Jackson', 20, 'Sophomore', 'Public Health', 'https://i.pravatar.cc/150?img=14', 'early_riser', 'off_campus', 'Carrboro', 600, 900, 5, 2, 2, 'Health conscious and routine-driven. Meal prep Sundays, gym at 7am, bed by 10:30. Very tidy.'),
-- ('Tyler Brooks', 21, 'Junior', 'Information Science', 'https://i.pravatar.cc/150?img=15', 'flexible', 'off_campus', 'Eastgate area', 650, 1000, 3, 2, 1, 'Tech nerd who codes and games. Easy to live with, just need solid wifi and my own desk space.'),
-- ('Amara Osei', 18, 'Freshman', 'Biology', 'https://i.pravatar.cc/150?img=16', 'early_riser', 'on_campus', 'Craige', 500, 750, 5, 1, 1, 'Pre-med from day one. Studious, clean, and quiet. Looking for the same so we can both succeed.'),
-- ('Ryan Nguyen', 22, 'Senior', 'Statistics', 'https://i.pravatar.cc/150?img=17', 'night_owl', 'off_campus', 'Carrboro', 700, 1000, 3, 2, 2, 'Data guy, night owl. I crunch numbers until 2am but keep headphones in. Very respectful of shared space.'),
-- ('Isabelle Ford', 20, 'Sophomore', 'Communications', 'https://i.pravatar.cc/150?img=18', 'flexible', 'on_campus', 'Morrison', 500, 800, 4, 1, 1, 'Social butterfly but I know when to dial it back. Love hosting but always ask roommates first.'),
-- ('David Hernandez', 19, 'Freshman', 'Computer Science', 'https://i.pravatar.cc/150?img=19', 'night_owl', 'on_campus', 'Granville Towers', 500, 850, 3, 1, 1, 'CS freshman into competitive programming and anime. Headphones always in, very low drama.'),
-- ('Fatima Al-Hassan', 21, 'Junior', 'Global Studies', 'https://i.pravatar.cc/150?img=20', 'early_riser', 'off_campus', 'Chapel Hill downtown', 650, 950, 4, 2, 1, 'International student who loves cooking cultural dishes. Early riser and very organized.'),
-- ('Jake Turner', 22, 'Senior', 'Exercise Science', 'https://i.pravatar.cc/150?img=21', 'early_riser', 'off_campus', 'Carrboro', 650, 950, 3, 2, 1, 'Gym every morning, healthy eating, in bed by 10:30. Laid back otherwise. No heavy smoking please.'),
-- ('Chloe Bennett', 20, 'Sophomore', 'Music', 'https://i.pravatar.cc/150?img=22', 'flexible', 'on_campus', 'Morrison', 500, 750, 3, 1, 1, 'Music major who practices in campus studios (not at home). Easy to live with, just love good vibes.'),
-- ('Omar Khalil', 21, 'Junior', 'Biomedical Engineering', 'https://i.pravatar.cc/150?img=23', 'night_owl', 'off_campus', 'Eastgate area', 700, 1050, 4, 2, 2, 'Engineer type. Detailed and clean. Prefer a roommate who respects structure and shared responsibilities.'),
-- ('Savannah Price', 19, 'Freshman', 'Environmental Science', 'https://i.pravatar.cc/150?img=24', 'flexible', 'on_campus', 'Ehringhaus', 500, 800, 4, 1, 1, 'Eco-conscious and outdoorsy. Love plants, hiking, and keeping a clean sustainable space.'),
-- ('Kevin Lee', 20, 'Sophomore', 'Physics', 'https://i.pravatar.cc/150?img=25', 'night_owl', 'on_campus', 'Craige', 500, 750, 3, 1, 1, 'Physics nerd, night owl. Quiet, keeps to himself, just needs a peaceful place to study.'),
-- ('Jasmine Cole', 22, 'Senior', 'Sociology', 'https://i.pravatar.cc/150?img=26', 'flexible', 'off_campus', 'Franklin Street area', 700, 1000, 4, 2, 1, 'Outgoing but conscious of personal space. Love deep convos, cooking, and keeping things neat.'),
-- ('Brendan Walsh', 21, 'Junior', 'History', 'https://i.pravatar.cc/150?img=27', 'night_owl', 'off_campus', 'Carrboro', 650, 950, 2, 2, 1, 'History buff and casual gamer. My room gets messy but common areas I keep clean. Promise.'),
-- ('Yara Mansour', 20, 'Sophomore', 'Neuroscience', 'https://i.pravatar.cc/150?img=28', 'early_riser', 'on_campus', 'Granville Towers', 500, 800, 5, 1, 1, 'Very studious and clean. Need someone equally serious about academics and shared cleanliness.'),
-- ('Chris Patel', 18, 'Freshman', 'Business', 'https://i.pravatar.cc/150?img=29', 'flexible', 'on_campus', 'Morrison', 500, 750, 3, 1, 1, 'First gen college student, figuring it out. Easy going, just looking for a friendly roommate.'),
-- ('Mia Robinson', 22, 'Senior', 'Linguistics', 'https://i.pravatar.cc/150?img=30', 'early_riser', 'off_campus', 'Chapel Hill downtown', 700, 1050, 4, 2, 2, 'Language nerd and morning person. I love a clean apartment and a roommate I can occasionally cook with.'),
-- ('Sam Ortega', 21, 'Junior', 'Media Studies', 'https://i.pravatar.cc/150?img=31', 'night_owl', 'off_campus', 'Carrboro', 650, 1000, 3, 2, 1, 'Filmmaker always working on short projects. Late nights but I use headphones and keep it respectful.'),
-- ('Elena Vasquez', 19, 'Freshman', 'Spanish', 'https://i.pravatar.cc/150?img=32', 'flexible', 'on_campus', 'Ehringhaus', 500, 800, 4, 1, 1, 'Bilingual, bubbly, and clean. Love cooking Spanish food and listening to reggaeton at a respectful volume.'),
-- ('James Owens', 20, 'Sophomore', 'Political Science', 'https://i.pravatar.cc/150?img=33', 'early_riser', 'off_campus', 'Eastgate area', 600, 900, 3, 2, 1, 'Involved in student government. Early riser, decently clean, pretty social. Looking for a laid back fit.'),
-- ('Hannah Scott', 21, 'Junior', 'Public Policy', 'https://i.pravatar.cc/150?img=34', 'early_riser', 'off_campus', 'Chapel Hill downtown', 700, 1000, 5, 2, 2, 'Policy nerd and clean freak in the best way. Early mornings, organized kitchen, shared chore chart please.'),
-- ('Alex Murphy', 22, 'Senior', 'Computer Science', 'https://i.pravatar.cc/150?img=35', 'flexible', 'off_campus', 'Carrboro', 700, 1100, 3, 2, 1, 'Full-stack dev, fully remote internship this semester. Need quiet work hours 9-5. Chill otherwise.'),
-- ('Tanya Singh', 19, 'Freshman', 'Biochemistry', 'https://i.pravatar.cc/150?img=36', 'early_riser', 'on_campus', 'Craige', 500, 750, 5, 1, 1, 'Science focused and super tidy. I wake up at 6 for lab prep. Looking for a serious co-habitant.'),
-- ('Ben Carter', 20, 'Sophomore', 'Geography', 'https://i.pravatar.cc/150?img=37', 'night_owl', 'on_campus', 'Granville Towers', 500, 800, 2, 1, 1, 'Laid back guy into maps, coffee, and late night YouTube rabbit holes. Chill roommate, I promise.'),
-- ('Nadia Petrov', 21, 'Junior', 'Economics', 'https://i.pravatar.cc/150?img=38', 'flexible', 'off_campus', 'Franklin Street area', 700, 1050, 4, 2, 1, 'International student from Russia. Very tidy, love cooking, and enjoy quiet evenings at home.'),
-- ('Darius King', 22, 'Senior', 'African American Studies', 'https://i.pravatar.cc/150?img=39', 'flexible', 'off_campus', 'Carrboro', 650, 950, 3, 2, 2, 'Creative writer and community organizer. Looking for a roommate who values culture and conversation.'),
-- ('Olivia Chang', 18, 'Freshman', 'Computer Science', 'https://i.pravatar.cc/150?img=40', 'night_owl', 'on_campus', 'Ehringhaus', 500, 800, 4, 1, 1, 'CS gal into hackathons and matcha. Night owl but I keep my space tidy. Looking for a fun first year experience.'),
-- ('Marcus Green', 20, 'Sophomore', 'Kinesiology', 'https://i.pravatar.cc/150?img=41', 'early_riser', 'off_campus', 'Eastgate area', 600, 900, 3, 2, 1, 'Athlete on the club soccer team. Early practices, early bedtime. Clean and pretty simple to live with.'),
-- ('Rachel Liu', 21, 'Junior', 'Mathematics', 'https://i.pravatar.cc/150?img=42', 'night_owl', 'off_campus', 'Carrboro', 650, 950, 4, 2, 1, 'Math major, quiet study sessions, occasional baking. Very clean and introverted but friendly.'),
-- ('Isaac Brown', 22, 'Senior', 'Religious Studies', 'https://i.pravatar.cc/150?img=43', 'early_riser', 'off_campus', 'Chapel Hill downtown', 700, 1050, 4, 2, 2, 'Reflective and calm. Keep a very organized home. Looking for a mature, respectful roommate.'),
-- ('Valentina Cruz', 19, 'Freshman', 'Theatre', 'https://i.pravatar.cc/150?img=44', 'night_owl', 'on_campus', 'Morrison', 500, 800, 3, 1, 1, 'Theatre kid with rehearsals until 10pm some nights. Fun energy but know when to keep it down.'),
-- ('Patrick O''Brien', 20, 'Sophomore', 'Marine Biology', 'https://i.pravatar.cc/150?img=45', 'flexible', 'on_campus', 'Granville Towers', 500, 800, 3, 1, 1, 'Beach kid studying inland. Surfer mentality — go with the flow, keep it chill, respect the space.'),
-- ('Diana Flores', 21, 'Junior', 'Education', 'https://i.pravatar.cc/150?img=46', 'early_riser', 'off_campus', 'Franklin Street area', 650, 950, 5, 2, 1, 'Future teacher, very structured and clean. I thrive on routine and need a space that reflects that.'),
-- ('Anton Reyes', 22, 'Senior', 'Architecture', 'https://i.pravatar.cc/150?img=47', 'night_owl', 'off_campus', 'Carrboro', 700, 1100, 3, 2, 1, 'Architecture senior so late nights are a given during crits. Creative space, I keep common areas clean though.'),
-- ('Simone Adams', 19, 'Freshman', 'Anthropology', 'https://i.pravatar.cc/150?img=48', 'flexible', 'on_campus', 'Ehringhaus', 500, 800, 4, 1, 1, 'Curious about everything. Love discussing big ideas. Clean, flexible schedule, very easy to get along with.'),
-- ('Leo Tanaka', 20, 'Sophomore', 'Asian Studies', 'https://i.pravatar.cc/150?img=49', 'night_owl', 'on_campus', 'Craige', 500, 750, 4, 1, 1, 'Anime, ramen, and late night studying. Quiet and clean. Looking for someone similar or at least tolerant.'),
-- ('Grace Williams', 21, 'Junior', 'Social Work', 'https://i.pravatar.cc/150?img=50', 'early_riser', 'off_campus', 'Chapel Hill downtown', 700, 1000, 4, 2, 2, 'Empathetic and organized. I care a lot about creating a comfortable home. Chore charts are a love language.');
