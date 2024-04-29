

# Running with podman
~~~
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ date
Mon Apr 29 05:31:12 PM WEST 2024
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ timedatectl 
               Local time: Mon 2024-04-29 17:31:16 WEST
           Universal time: Mon 2024-04-29 16:31:16 UTC
                 RTC time: Mon 2024-04-29 16:31:16
                Time zone: Europe/Lisbon (WEST, +0100)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ podman run --tz=Europe/Lisbon quay.io/rhn_support_arolivei/samplenetapp01:v1
Hello, World!
UTC Time Before: 04/29/2024 16:31:19
Local Time: 04/29/2024 17:31:19)
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ podman run --tz=Europe/Paris quay.io/rhn_support_arolivei/samplenetapp01:v1
Hello, World!
UTC Time Before: 04/29/2024 16:31:29
Local Time: 04/29/2024 18:31:29)
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ podman run --tz=Pacific/Auckland quay.io/rhn_support_arolivei/samplenetapp01:v1
Hello, World!
UTC Time Before: 04/29/2024 16:32:12
Local Time: 04/30/2024 04:32:12)
~~~

# Running with Kubernetes(e.g. MicroShift)

~~~
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: timezone
    lang: dotnet-core
  name: timezone-pod
  namespace: test
spec:
  containers:
  - image: quay.io/rhn_support_arolivei/samplenetapp01:v1
    env: 
      - name: TZ
        value: "Pacific/Johnston"
    name: timezone
    securityContext:
      allowPrivilegeEscalation: false
      seccompProfile:
        type: RuntimeDefault
      capabilities:
        drop:
        - ALL
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ oc apply -f pod.yaml 
pod/timezone-pod created
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ oc get pods
NAME           READY   STATUS      RESTARTS     AGE
timezone-pod   0/1     Completed   1 (1s ago)   2s
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ oc logs timezone-pod
Hello, World!
UTC Time Before: 04/29/2024 17:56:05
Local Time: 04/29/2024 07:56:05)
arolivei@arolivei-thinkpadp1gen3:~/utils/code/App$ 
~~~
