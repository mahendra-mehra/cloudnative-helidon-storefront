#!/bin/bash
#
# Copyright (c) 2019, 2020, 2021 Oracle and/or its affiliates. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
echo Updating StatusResource version
mv src/main/java/com/oracle/labs/helidon/storefront/resources/StatusResource.java .
cat StatusResource.java | sed s/0.0.1/0.0.2/ > StatusResourcev2.java
mv StatusResourcev2.java src/main/java/com/oracle/labs/helidon/storefront/resources/StatusResource.java
rm StatusResource.java
. ./repoStorefrontConfig.sh
mvn package
echo Resetting StatusResource version
mv src/main/java/com/oracle/labs/helidon/storefront/resources/StatusResource.java .
cat StatusResource.java | sed s/0.0.2/0.0.1/ > StatusResourcev1.java
mv StatusResourcev1.java src/main/java/com/oracle/labs/helidon/storefront/resources/StatusResource.java
rm StatusResource.java
docker build  --tag $REPO/storefront:latest --tag $REPO/storefront:0.0.2 --file Dockerfile .
docker push $REPO/storefront:latest
docker push $REPO/storefront:0.0.2
echo built and pushed v0.0.2
