install:
# install:
	#install commands 
	pip install --upgrade pip &&\
	pip install -r requirements.txt
format:
	#format code
	black *.py mylib/*.py
lint:
	#flake8 or #pylint
	pylint --disable=R,C mylib/*.py
build:
	#build container
	docker build -t deploy-fastapi .
run:
	#run docker
	docker run -p 127.0.0.1:8080:8080 b4f9f0b4e374
test:
	#test
	python -m pytest -vv --cov=mylib --cov=main test_*.py 
deploy:
	#deploy
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 070734408531.dkr.ecr.us-east-1.amazonaws.com
	docker build -t wiki .
	docker tag wiki:latest 070734408531.dkr.ecr.us-east-1.amazonaws.com/wiki:latest
	docker push 070734408531.dkr.ecr.us-east-1.amazonaws.com/wiki:latest
all: install format build lint test deploy