FROM python:3.6

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "flask-app.py"]

# To build image: 
# docker build . -t edenjose/eden-flask-app

# To run container from image:
# docker run -p 8080:888 --name flask-app -v /home/centos/flask:/opt/ edenjose/eden-flask-app



