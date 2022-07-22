
resource symbolicname 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'string'
  location: 'string'
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  identity: {
    type: 'string'
    userAssignedIdentities: {}
  }
  properties: {
    configuration: {
      activeRevisionsMode: 'string'
      
      ingress: {
        external: bool
        targetPort: int
      }
     
    }
    managedEnvironmentId: 'string'
    template: {
      containers: [
        {
         
          env: [
            {
              name: 'string'
              value: 'string'
            }
          ]
          image: 'string'
          name: 'string'
          resources: {
            cpu: int
            memory: 'string'
          }
  
        }
      ]
      scale: {
        maxReplicas: int
        minReplicas: int
        
      }
    }
  }
}
