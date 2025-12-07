import requests
import time
import sys

URL_TO_TEST = 'https://localhost/'  
TOTAL_REQUESTS = 50 
DELAY_BETWEEN_REQUESTS_SECONDS = 0.000

successful_requests = 0
rate_limited_requests = 0
other_errors = 0

try:
    for i in range(1, TOTAL_REQUESTS + 1):
        try:
            response = requests.get(URL_TO_TEST, verify=False, timeout=5) # 'verify=False' is often needed for self-signed certificates (like NGINX default)
            status_code = response.status_code

            if status_code == 200:
                successful_requests += 1
                print(f"Request {i:02d}: Success (200)")
            elif status_code == 503 or status_code == 429:
                rate_limited_requests += 1
                print(f"Request {i:02d}: LIMITED! ({status_code})")
            else:
                other_errors += 1
                print(f"Request {i:02d}: Other Error ({status_code})")

        except requests.exceptions.RequestException as e:
            print(f"Request {i:02d}: Connection/Request Error: {e}", file=sys.stderr)
            other_errors += 1
            
        time.sleep(DELAY_BETWEEN_REQUESTS_SECONDS)

except KeyboardInterrupt:
    print("\nTest interrupted by user.")
    
finally:
    print(f"Total Requests Sent: {TOTAL_REQUESTS}")
    print(f"Successful (200): {successful_requests}")
    print(f"Rate Limited (429/503): {rate_limited_requests}")