# ML4T Docker Environment Install Guide
*Current as of June 2023*

Docker will allow you to build a standardized environment that contains all required packages needed for Python in this course.

## Before Install
This guide assumes you have admin or root privileges on your machine. For Windows users you need to be able to install/use WSL.

Download + unzip your semesters stater code such as:
**ML4T_2023Sum.zip** and **Assess Portfolio**
and current/all project stater code such as: **Martingale_2023Sum.zip**
and
save these to the same directory you plan on using for the semester on your local machine such as:
> **C:\Users\ML4T-Student\Desktop\ML4T_2023Summer**

or

> **/Users/ML4T-Student/Desktop/ML4T_2023Summer**

**it doesn't have to be in your Desktop*

Ensure your file structure hierarchy looks the same as shown in this image:

![hierarchy image](https://i0.wp.com/lucylabs.gatech.edu/ml4t/wp-content/uploads/2021/08/p2_optimize_something_file_structure.png?w%3D550%26ssl%3D1)
## Conda Environment
Save the following as **environment.yml** in the same directory as the previous files (i.e. ML4T_2023Summer/):
```
name: ml4t
channels:
- conda-forge
- defaults
dependencies:
- python=3.6
- cycler=0.10.0
- kiwisolver=1.1.0
- matplotlib=3.0.3
- numpy=1.16.3
- pandas=0.24.2
- pyparsing=2.4.0
- python-dateutil=2.8.0
- pytz=2019.1
- scipy=1.2.1
- seaborn=0.9.0
- six=1.12.0
- joblib=0.13.2
- pytest=5.0
- pytest-json=0.4.0
- future=0.17.1
- pprofile=2.0.2
- pip
- pip:
- jsons==0.8.8
- gradescope-utils
- subprocess32
```
Now we should have our project starter code and our **environment.yml** file in our directory.

## Docker
Now we need to download two more files into our course directory (i.e., ML4T_2023Summer):
>**Dockerfile**

and

>**docker-compose.yml**

# ADD INSTRUCTIONS HERE EXPLAINING WHERE TO DOWNLOAD THESE FILES OR SIMPLY PASTE THE CONTENTS HERE AND HAVE THE STUDENTS COPY + SAVE THE FILES WITH THE CORRECT FILE NAMES (THE NAMES OF THE FILES MUST BE THE EXACT SAME AS ABOVE)

## Install Docker Desktop

* Note to Linux users: *All Linux information was tested with Ubuntu 22.04*. To install Docker Desktop requires installing the CA certs and GPG keys and the repository info, I'd recommend just installing docker and docker compose, on Ubuntu would be:
> apt install docker docker-compose

Download: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
and complete the installation steps. Docker desktop installation requires a restart on Windows as well as an updated WSL version (Docker Desktop will prompt you if your settings need to be updated).

#### For a better DX w/ your IDE, run the docker commands from within your IDE terminal
## VS Code - PyCharm - (N)Vim
For the VS Code users you can open the terminal with the shortcut: ``ctrl + ` `` to run the docker compose commands. The same can be accomplished in PyCharm, shortcut: `Alt + F12` to open the terminal (or View -> Tool Windows -> Terminal).

Windows users: it's worth noting that [git bash](https://git-scm.com/download/win) is more convienent than Powershell if you're using `git`

## Run docker-compose
**⚠️with Docker Desktop running:**

Open your terminal or powershell and navigate to your directory that contains your course materials. e.g. =>
> **Username@PC:/$> cd /Users/Username/ML4T_2023Summer**

or

> **PS C:\\> cd C:\Users\Student\Desktop\ML4T_2023Summer**

to build the image and start the container run:

>`docker-compose -f docker-compose.yml up --build -d; docker exec -it $(docker ps --filter "name=ml4t" -q) bash`

* if using Linux (as non-root user) run:
> `sudo docker-compose -f docker-compose.yml up --build -d; sudo docker exec -it $(sudo docker ps --filter "name=ml4t" -q) bash`

to stop the container run:


>`docker compose -f docker-compose.yml down`

if you are executing from within the container you can just run:
> `exit`

⏳These commands will take a little while to complete.

**(when the container is terminated your local files are still safe) but as a good rule of thumb save your files and push your changes to your repository**

### 🩺💻**Sanity Check**

If you close your terminal, no worries, run: `docker exec -it $(docker ps --filter "name=ml4t" -q) bash` to get back into the container. To test your environment and make sure everything is correct try running `python3 --version` to verify the correct Python version. You should be automatically placed in your root directory after you run the docker compose commands which will be the same as your local *ML4T_2023Summer* directory. Also you're running as root! That's a lot of power. But that's the benefit of containers you can always create a new one if this one fails.


You made it! After navigating to your directory containing the *grade_anlysis.py* file you can run: `PYTHONPATH=../:. python grade_analysis.py` Now you can start building your projects. Quality-of-life tip, run: `echo "alias py='python3'" >> ~/.bashrc` then run: `source ~/.bashrc` this allows you to run `py` intead of having to type out `python3`

This set-up's work flow: edit files + save -> run Python interpreter in the built-in terminal w/ your IDE (you can also do your Python execution from a separate terminal window you just need to `docker exec -it $(docker ps --filter "name=ml4t" -q) bash` into your container)
Remember that all changes made from the command line will be reflected in your local machine's directory. If you run `touch testfile.txt` from within the container a new file named `textfile.txt` will exist in your local ML4T_2023Summer directory as well. 🚫Equally if you start executing `rm -r ./*` this will be bad (i.e. as root nothing will stop you from doing a lot of damage and bind mounts make your local files accessible to this Docker container).

# Bonus: Git

Getting good with git in GaTech Github. Go to https://github.gatech.edu/
with your GaTech credentials. Here you can create repositories, save your code, and retrieve it from anywhere in the world (probably). Click the green button that says 'New' then name your repo and you are ready to start saving your code.

In a project directory such as: *./martingale* run the following commands to get started
```
echo "# test" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.gatech.edu/cruhe3/test.git
git push -u origin main
```

or a slightly simplified-ish version:
>- `git init && git status`

>- `git add -A` OR   `git add filename.py`

>- `git commit -m "first commit"`
>- `git remote add origin https://github.gatech.edu/`**`YOUR_USERNAME`**`/`**`YOUR_PROJ_REPO`**`.git`
>- `git push -u origin HEAD`

if you are ever moving to a different machine you can run `git fetch` and `git pull` to pull the latest changes in your repo. *You may also need to set the remote repository as well.

**Keep your `Dockerfile`, `docker-compose.yml`, and `environment.yml` in a repo in your gatech github account, this allows you to be able to access the same environment from anywhere 🌍**


### Why is this useful?
As stated previously, building a docker image allows you to create a standardized environment that is self-sufficient and independent to your local operating system. What these instructions do is build a Docker image and then load the image into a Docker container. These containers are ephemeral. If they crash or have issues, no problem, we can spin up another one with the exact same parameters. This allows you to build the same environment on any machine anywhere you need to be. So how does this work? To simplify what is happening: Docker is creating a virtual environment (context) that has access to some of your files, more specifically, the directory with all your coursework. You can execute commands inside the Docker container which has access to your local files. It's like the container exists as a virtual operating system that is completely separate from your local machine but can peek through this virtual curtain to view and manipulate your files. This allows it to run programs like the Python interpreter without having any interaction or communication with your local machine.


Made for CS-7646 by crooruhe