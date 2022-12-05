{{/* Returns the primary service object */}}
{{- define "ix.v1.common.lib.util.service.primary" -}}
  {{- $enabledServices := dict -}}
  {{- range $name, $service := .Values.service -}}
    {{- if $service.enabled -}}
      {{- $_ := set $enabledServices $name $service -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $service := $enabledServices -}}
    {{- if (hasKey $service "primary") -}}
      {{- if $service.primary -}}
        {{- if $result -}}
          {{- fail "More than one services are set as primary. This is not supported." -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- if eq (len $enabledServices) 1 -}}
      {{- $result = keys $enabledServices | mustFirst -}}
    {{- else -}}
      {{- if $enabledServices -}}
        {{- fail "At least one Service must be set as primary" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
