defmodule OtpLibclusterHordeTemplateProject do
  @moduledoc File.read!(Path.join([__DIR__, "../README.md"]))

  use MixTemplates,
    name: :otp_libcluster_horde_template_project,
    short_desc: "Template that ties Kubernetes, LibCluster and Horde",
    source_dir: "../template",
    options: [
      sup: [to: :is_supervisor?, default: true],
    ]
end
