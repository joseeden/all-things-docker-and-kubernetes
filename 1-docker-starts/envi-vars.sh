
# We can specify an environment variable which we can use in a given code.
# This is useful when we don't want to modify the code and instead use variables
# for any values that we need to change in the code

# As an example, we have color-message.py which display a message on 
# backgroudn color which we can change

```python
# color-message.py
import os
from flask import Flask

app = Flask(__name__)

color= os.environ.get(APP_COLOR)

@app.route("/")
def main():
    print(color)
    return render_template('hello.html', color=color)

if __name__="__main__":
    app.run(host="0.0.0.0", port="8080")
```
