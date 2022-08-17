FROM python:3.8
WORKDIR /app
COPY . .
RUN pip3 install --no-cache-dir flask flask_restful python-dotenv
EXPOSE 5000
CMD ["python3","/app/app.py"]