# Use an official Python runtime as a parent image
FROM python:3.9.16

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements_full.txt --proxy=192.168.0.6:11992

# Clone the repository
# RUN git clone https://github.com/MrGreyfun/Local-Code-Interpreter.git

# Copy the config.example.json to src/config.json
# RUN cp /app/Local-Code-Interpreter/config_example/config.example.json /app/Local-Code-Interpreter/src/config.json

# 使用sed命令更改API_KEY的值
# RUN sed -i 's/"API_KEY": "[^"]*"/"API_KEY": ""/' /app/Local-Code-Interpreter/src/config.json
RUN sed -i 's/\"API_KEY\": \".*\"/\"API_KEY\": \"\"/' /app/src/config.json  

# Change into the cloned repository
WORKDIR /app/src

# Make port 7860 available to the world outside this container
EXPOSE 7860

# Run web_ui.py when the container launches
CMD ["python", "web_ui.py"]

# build
# docker build --pull --rm -f "Dockerfile" -t localcodeinterpreter:latest "." 

# run
# docker run   --rm -it  -e OPENAI_API_KEY=<youApikey> -p 7860:7860 localcodeinterpreter