
import os
from dotenv import load_dotenv
from google import genai
import json
#import get_db from database.py

load_dotenv()
api_key=os.environ.get("GEMINI_API_KEY")

client = genai.Client(api_key=api_key)

def get_compatibility(user1,user2):
    prompt = f""" You are a roommate compatibility calculator. You are given 2 user details and you need to calculate a score between 0-100 between these two people. Score their compatibility and return a JSON object ONLY. No extra text/markdown and no code. 

    User 1: 
    Name - {user1['name']}
    Sleep Schedule - {user1['sleep_schedule']}
    Cleanliness - {user1['cleanliness']}
    Living Preferences - {user1['living_preference']}
    Rent Budget - {user1['rent_min']} - {user1['rent_max']}

    User 2: 
    Name - {user2['name']}
    Sleep Schedule - {user2['sleep_schedule']}
    Cleanliness - {user2['cleanliness']}
    Living Preferences - {user2['living_preference']}
    Rent Budget - {user2['rent_min']} - {user2['rent_max']}

    Format: {{"score": <score>, "reasoning": <reasoning one sentence only>"}}
              
              """

    response = client.models.generate_content(
        model="gemini-3-flash-preview", contents=prompt)
    try:
        text = response.text
        text = text.strip().replace("```json", "").replace("```", "")
        result = json.loads(text)
        return result
    except:
        return {"score": 50, "reason": "Could not calculate compatibility"}

def top_matches(current_user, all_users):
    results = []
    for user in all_users:
        if user['name']==current_user['name']:
            continue
        if user['name'] != current_user['name']:
            compatibility = get_compatibility(current_user, user)
              

            if compatibility['score'] >= 75:
                results.append({"user": user, "compatibility": compatibility, "reason": compatibility['reasoning']})  

                results.sort(key=lambda x: x['compatibility']['score'], reverse=True)

        return results 
    

    # temporary test - delete this later
user1 = {
    "name": "Aiden Park",
    "sleep_schedule": "night_owl",
    "cleanliness": 3,
    "living_preference": "on_campus",
    "rent_min": 500,
    "rent_max": 800
}

user2 = {
    "name": "Maya Patel",
    "sleep_schedule": "early_riser",
    "cleanliness": 5,
    "living_preference": "on_campus",
    "rent_min": 500,
    "rent_max": 750
}

print(get_compatibility(user1, user2))