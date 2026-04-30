# Reproducibility Engineering - Lab Session 1 Material

This folder contains material for the first lab session of Reproducibility Engineering at University of Passau in the summer term 2026.

The photograph of the [fox](LabSession1/res/fox.jpg) was taken by [Federico Di Dio](https://unsplash.com/photos/KYBy7FfU0X0).




Lab Objective
This lab introduces Docker and demonstrates how to create reproducible environments using containers. The goal is to ensure that software behaves consistently across different systems.


Key Concepts

Docker Image: Blueprint used to create containers  
Container: Running instance of an image  
Dockerfile: Instructions to build an image  
Bind Mount: Shared directory between host and container  


 Exercise 1: Building a Docker Image

Steps
bash:
'git clone https://git.fim.uni-passau.de/koehnen/RepEng
cd RepEng/LabSession1
docker build -t lab1 .
docker image ls'


Result
Docker image `lab1` was successfully created.


Exercise 2: Running a Container

Bash
'docker run -it --name lab1-cont lab1'


Observations
- Prompt changed to: `repro@<container_id>`
- This indicates we are inside the container
- Working directory contains:
  - `fox.jpg`
  - `fox_secret.jpg`



Exercise 3: Image Comparison

(a) Visual Inspection
- Images look identical
- File sizes are similar




(b) SHA-256 Hash Comparison

bash
'certutil -hashfile fox.jpg SHA256
certutil -hashfile fox_secret.jpg SHA256'


Result
- Hash values are different
- This proves the images are not identical




(c) Statistical Analysis using Python

Steps inside container:

bash
"pip3 install numpy pillow
python3 correlation.py"


Output
"
Pearson correlation: 0.9999988232011107
"

Interpretation
- Value is very close to 1
- This means images are almost identical
- However, small differences exist (hidden data)




(d) File Transfer using `docker cp`

Steps:

bash
"docker cp lab1-cont:/home/repro/correlation.py ~
# edit file on host
docker cp ~/correlation.py lab1-cont:/home/repro/correlation.py"

Result
- File successfully edited on host
- Changes reflected inside container



(e) Bind Mounts

Run container with mount:

bash
"docker run -it --name lab1-cont-mount \
-v C:\Users\user\lab1-mount:/home/repro/mount lab1
"


Test:
bash
"
./mount/test.sh
"

 Output
"
Test passed!
"



Interpretation
- Files created on host are accessible in container
- Enables real-time file sharing



Challenges Encountered

- Missing Python packages (`numpy`, `pillow`)
- File path issues (`res/fox.jpg`)
- Confusion between host vs container environment
- Attempted to run Docker inside container (not possible)



Key Learnings

- Docker ensures reproducibility across systems  
- Containers isolate environments but share OS kernel  
- Volume mounting is essential for development workflows  
- Debugging paths is critical when working with containers  



Conclusion
This lab demonstrated how Docker can be used to reproduce computational environments reliably. Even when files appear identical, deeper analysis (hashing and correlation) reveals hidden differences.



Project Structure
"
LabSession1/
│
├── Dockerfile
├── correlation.py
├── README.md
└── res/
    ├── fox.jpg
    └── fox_secret.jpg
"
