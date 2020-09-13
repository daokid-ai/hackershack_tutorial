build:
	docker build --force-rm $(options) -t hackershack-website-tutorial:latest .

build-prod:
	$(MAKE) build options="--target production"

compose-start:
	docker-compose up --remove-orphans $(options)

compose-stop:
	docker-compose down --remove-orphans $(options)

compose-manage-py:
	docker-compose run --rm $(options) website python manage.py $(cmd)

compose-makemigrations:
	docker-compose run --rm $(options) website python manage.py makemigrations

compose-dbmigrate:
	docker-compose run --rm $(options) website python manage.py migrate

compose-createsu:
	docker-compose run website python manage.py createsuperuser
