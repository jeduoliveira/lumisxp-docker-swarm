LumisXP cluster no Docker Swarm 
=============================

Neste repositório você irá encontrar tudo que é necessário para instalar um cluster de LumisXP no Docker Swarm.


Como fazer a instalação ? 
--------------

Para criar um cluster do LumisXP é necessário ter a licença da versão enterprise. Acessar o site do framework [LumisXP](https://lumisportal.lumis.com.br)

1. Clonar o repositório repositório 

        git clone https://github.com/jeduoliveira/lumisxp-docker-swarm

2. Colocar a sua versão do enterprise LumisXP no diretorio docker/lumisxp/packages

3. Criar o network externo para o traefik fazer o discovery das instancias.

        docker network create -d overlay net

4. Executar os comandos make abaixo

    4.1. Criar as imagens customizadas
        
            make build

    4.2. Deploy do MySQL 

            make deploy-database

    4.3. Deploy do cluster ElasticSearch 
    
            make deploy-elastic

    4.4. Deploy do LumisXP 
    
            make deploy-lumis
            
    4.4.1. Acompanhe o Log do service para verificar o andamento da criação das tabelas e os dados iniciais.}

            docker service logs lumisxp_lumisportal -f 

    4.5. Deploy do traefik 
    
            make deploy-traefik

5. Escalando o lumisxp service

        docker service scale lumisxp_lumisportal=2


Utilizando o Labs Play With Docker
=================================

O qué é?
-----
Play with Docker é um ambiente online e gratuito para testes com containers. Fato de amplo conhecimento da parte de muitos Desenvolvedores e Profissionais antenados com temas em alta na área de TI, Docker conta atualmente com um excelente suporte a diversas distribuições Linux.

```https://labs.play-with-docker.com/```
