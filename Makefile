dev:
	docker build -t alpr-python -f dev.Dockerfile .
	docker run --name test_alpr --rm -p 5000:5000 -v $(pwd):/code -it alpr-python

prod:
	docker build -t alpr-prod-python .

run-prod: prod
	docker run --name prod_alpr --rm -p 5000:5000 -v $(pwd):/code -it alpr-prod-python

test-prod:
	time curl -XPOST -F 'file=@./plate_number.jpg' http://localhost:5000