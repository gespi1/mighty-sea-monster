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

----

5. Solve the problem in question 4 using any programming language you like. [problem 5](./5)

----

6. write a Terraform module that creates the following resources in IAM;-A role, with no permissions, which can be assumed by users within the same account,-A policy, allowing users / entities to assume the above role,-A group, with the above policy attached,-A user, belongingto the above group.All four entities should have the same name, or be similarly named in some meaningful way given thecontext e.g. prod-ci-role, prod-ci-policy, prod-ci-group, prod-ci-user; or just prod-ci. Make the suffixes toggleable, if you like.
 [problem 6](./6)