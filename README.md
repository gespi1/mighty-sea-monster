# Mighty Sea Monster

1. Write a Dockerfile to run Litecoin 0.18.1 in a container. It should somehow verify the checksum
of the downloaded release (there's no need to build the project), run as a normal user, and when run without any
modifiers (i.e. docker run somerepo/litecoin:0.18.1) should run the daemon, and print its output to the console.
The build should be security conscious (and ideally pass a container image security test such as Anchore). 
2. Write a Kubernetes StatefulSet to run the above, using persistent volume claims and resource limits.
3. Write a simple build and deployment pipeline for the above using groovy / Jenkinsfile,
Travis CI or Gitlab CI
- [problems 1-3](./1-3)

----
4. Source or come up with a text manipulation problem and solve it with at least two of awk, sed, tr
and / or grep. 
- [problem 4](./4)