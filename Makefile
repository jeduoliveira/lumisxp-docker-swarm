deploy-elastic:
	docker stack deploy --compose-file swarm-elastic.yml lumisxp

deploy-database:
	docker stack deploy --compose-file swarm-database.yml lumisxp

deploy-lumis:
	docker stack deploy --compose-file swarm-lumis.yml lumisxp

deploy-nginx:
	docker stack deploy --compose-file swarm-nginx.yml lumisxp

deploy-traefik:
	docker stack deploy --compose-file swarm-traefik.yml lumisxp

deploy: deploy-database deploy-elastic deploy-lumis deploy-traefik deploy-nginx

build-nginx:
	cd docker/nginx && docker build -t jeduoliveira/labs:nginx-1.19.3-alpine .

build-elastic:
	cd docker/elasticsearch && docker build -t jeduoliveira/labs:elasticsearch-7.9.2 .

build-lumis:
	cd docker/lumisxp/packages && curl https://lumisportal-repo.s3.amazonaws.com/lumisportal_12.5.0.200928.zip --output lumisportal_12.5.0.200928.zip
	cd docker/lumisxp && docker build -t jeduoliveira/labs:lumisxp-12.5.0.200928 .

build: build-nginx build-elastic build-lumis


push:
	docker push jeduoliveira/labs:nginx-1.19.3-alpine
	docker push jeduoliveira/labs:elasticsearch-7.9.2
	docker push jeduoliveira/labs:lumisxp-12.5.0.200928
	
pull:
	docker pull jeduoliveira/labs:nginx-1.19.3-alpine
	docker pull jeduoliveira/labs:elasticsearch-7.9.2
	docker pull jeduoliveira/labs:lumisxp-12.5.0.200928

ansible-run:
	ansible-playbook -i ansible/inventory/hosts ansible/playbook.yml

terraform-init:
	cd terraform && terraform init  
	cd terraform && terraform apply -target=module.vpc  -auto-approve
	cd terraform && terraform apply -auto-approve