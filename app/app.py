from flask import Flask
import json, urllib.request

app = Flask(__name__)

@app.route('/jokes')
def get_100_jokes():
    page = urllib.request.urlopen("http://bash.org.pl/text").read()
    tmp_file = open("jokes.tmp", "wb")
    tmp_file.write(page)
    resp = {}
    count = 0
    with open("jokes.tmp") as fh:
        joke = fh.read()
        joke = joke.split("\n%\n")
        for joke_line in joke:
            resp[count] = joke_line
            count+=1
            if count == 5: 
                break
    return json.dumps(resp)

app.run(host='0.0.0.0')
