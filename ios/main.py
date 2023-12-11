# from selenium import webdriver
# from selenium.webdriver.common.keys import Keys
# import time
# from selenium.webdriver.common.by import By
# from selenium.webdriver.chrome.options import Options
# from selenium.webdriver.chrome.service import Service
# from webdriver_manager.chrome import ChromeDriverManager
# from selenium.common.exceptions import NoSuchElementException


# options = webdriver.ChromeOptions()
# service = Service(ChromeDriverManager().install())
# driver = webdriver.Chrome(service=service, options=options)

# #ファイルパスの変更を宜しくお願い致します。
# file_path ='/Users/atsukikitano/プログラミング最終課題　2297124z.docx'
# userId='2297124z'
# userPassword='2zCX=vCn'

# url1 = "https://beefplus.center.kobe-u.ac.jp"

# url2="https://beefplus.center.kobe-u.ac.jp/lms/course/report/submission?idnumber=20233Z0295001&reportId=10598"

# def send_text_to_element(driver, element_locator, text):
#     element = driver.find_element(*element_locator)
#     element.send_keys(text)

# def click_element(driver, element_locator):
#     try:
#         element = driver.find_element(*element_locator)
#         element.click()
#     except NoSuchElementException:
#         print(f"Element not found: {element_locator}")
#         return
    
# steps = [
#     # 以前のステップ...
#     {"action": "get", "url": url1},
#     {"action": "click", "locator": (By.LINK_TEXT, 'サインイン')},
#     {"action": "wait", "seconds": 0.5},
#     {"action": "input", "locator": (By.ID, 'username'), "text": userId},
#     {"action": "input", "locator": (By.ID, 'password'), "text": userPassword},
#     {"action": "click", "locator": (By.ID, 'kc-login')},
#     {"action": "get", "url": url2},
#     {"action": "wait", "seconds": 1},
#     {"action": "input", "locator": (By.CLASS_NAME, 'fileSelectInput'), "text": file_path},
#     {"action": "wait", "seconds": 1},
#     {"action": "click", "locator": (By.CSS_SELECTOR, 'input.input-checkbox.deleteCheck')},
#     {"action": "wait", "seconds": 1},
#     {"action": "click", "locator": (By.ID, 'report_submission_btn')},
#     {"action": "wait", "seconds": 1},
#     {"action": "click", "locator": (By.ID, "submitButton")},
#     {"action": "wait", "seconds": 1},
# ]

# for step in steps:
#     if step["action"] == "input":
#         send_text_to_element(driver, step["locator"], step["text"])
#     elif step["action"] == "click":
#         click_element(driver, step["locator"])
#     elif step["action"] == "get":
#         driver.get(step["url"])
#     elif step["action"] == "wait":
#         time.sleep(step["seconds"])

# print("終了しました。")

# driver.quit()

def bubble_sort(arr):
    n = len(arr)
    for i in range(n - 1):
        for j in range(n - i - 1):
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                print("あああ")

# 使用例
my_list = [1,4,2,3]
bubble_sort(my_list)
print("ソート済みリスト:", my_list)
