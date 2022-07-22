
data "google_service_account" "msk-apigateway-service-account-id" {
  account_id = var.msk-service-account-id
}

resource "google_workflows_workflow" "workflows_example" {
  name            = var.workflow-name
  region          = var.msk-global-configurations["REGION"]
  description     = var.workflow-description
  service_account = data.google_service_account.msk-apigateway-service-account-id.id
  source_contents = <<-EOF
  main:
    params: [args]
    steps:
        - WaitSixthySecondsBeforeExecuting:
            try:
                call: sys.sleep
                args:
                    seconds: 120
            except:
                as: e
                steps:
                    - LogErrorMessageWhenWaitingToExecuteOtherSteps:
                        call: sys.log
                        args:
                            text: $${e}
                    - ReturnMessageWhenErrorOccuresWaitingToExecuteSteps:
                        return: $${e}
        - DeclareVariables:
            try:
                assign:
                    - deleteotpurl: $${args.deleteotpurl}
                    - username: $${args.username}
                    - otp_code: $${args.otp_code}
                    - date: $${args.date}
                    - namespace: $${args.namespace}
            except:
                as: e
                steps:
                    - LogErrorMessageDuringVariableDeclaration:
                        call: sys.log
                        args:
                            text: $${e}
                    - ReturnMessageWhenErrorOccures:
                        return: $${e}
        
        - CallDeleteTokenFunction:
            try:
                call: http.post
                args:
                    url: $${deleteotpurl}
                    auth:
                        type: OIDC
                    body:
                        date: $${date}
                        username: $${username}
                        otp_code: $${otp_code}
                        namespace: $${namespace}
                result: delete_otp
            next: DisplayOutputAfterExecutingFunction
            except:
                as: e
                steps:
                    - LogErrorMessageDuringCallingOFDeleteOtpFunction:
                        call: sys.log
                        args:
                            text: $${e}
                    - ReturnMessageWhenCallingDeleteOtpToken:
                        return: $${e}
        -  DisplayOutputAfterExecutingFunction:
                try:
                    return: $${delete_otp}
                except:
                    as: e
                    steps:
                        - LogOutputAfterTryingToDisplayOutputOfCallDeleteOtpFunction:
                            call: sys.log
                            args:
                                text: $${e}
                        - ReturnMessageWhenErrorOccuresCallingLogOutputAfterTryingToDisplayOutputOfCallDeleteOtpFunction:
                            return: $${e}
EOF

depends_on = [data.google_service_account.msk-apigateway-service-account-id]
}
