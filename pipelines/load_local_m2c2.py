import pandas as pd
import json
df = pd.read_json("~/Desktop/data_sample_rcare.json")
slim_df = df[['uid', 'created_utc', 'activity_name', 'metadata', 'user_uid', 'session_uid', 'activity_params']]
slim_df.to_csv('data_sample_rcare.csv', index=False)