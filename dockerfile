FROM python:3.13.4-alpine3.22

FROM python:3.11-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory.
# This is done first to leverage Docker's layer caching. If requirements.txt
# doesn't change, this layer won't be rebuilt on subsequent builds.
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
# --no-cache-dir: Disables the pip cache to keep the image size smaller.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code to the working directory
COPY . .

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run the application when the container launches.
# Use --host 0.0.0.0 to make it accessible from outside the container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

