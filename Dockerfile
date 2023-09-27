# Use an official Python runtime as a parent image
FROM python:3.9.16

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Clone the repository
# RUN git clone https://github.com/MrGreyfun/Local-Code-Interpreter.git  

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements_full.txt --proxy=192.168.0.6:11992
# Copy the config.example.json to src/config.json
RUN cp /app/config_example/config.example.json /app/src/config.json

# change API_KEY Value To ""
RUN sed -i 's/\"API_KEY\": \".*\"/\"API_KEY\": \"\"/' /app/src/config.json  

# Change into the cloned repository
WORKDIR /app/src

# Make port 7860 available to the world outside this container
EXPOSE 7860


ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=7860
# ENV OPENAI_API_KEY=<youApikey>

# Run web_ui.py when the container launches
CMD ["python", "web_ui.py"]

# build
# docker build --pull --rm -f "Dockerfile" -t localcodeinterpreter:latest "." 

# run
# docker run   --rm -it  -e OPENAI_API_KEY=<youApikey> -e API_base="https://api.pawan.krd/backend-api/conversation/v1" -p 7860:7860 localcodeinterpreter
# docker run   --rm -it  -e OPENAI_API_KEY=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 -e OPENAI_API_base="https://ai.fakeopen.com/api/conversation/v1" -p 7860:7860 localcodeinterpreter

# docker run   --rm -it  -e OPENAI_API_KEY=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 -e OPENAI_API_base="https://chatgpt2.nextweb.fun/api/proxy/v1" -p 7860:7860 localcodeinterpreter