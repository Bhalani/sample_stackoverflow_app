module Features
  module JsHelpers
    def fill_in_ckeditor(element_id, answer_content)
      page.execute_script <<-SCRIPT
        for(instance in CKEDITOR.instances){
          CKEDITOR.instances[instance].setData(\"#{answer_content}\");
        }
        $('textarea##{element_id}').text(\"#{answer_content}\");
      SCRIPT
    end
  end
end
