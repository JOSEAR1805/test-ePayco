<template>
  <a-row>
    <a-col :span="24">
      <a-breadcrumb>
        <a-breadcrumb-item>
          <a href="/">
            <a-icon type="home" />
          </a>
        </a-breadcrumb-item>
        <a-breadcrumb-item>Billetera</a-breadcrumb-item>
        <a-breadcrumb-item>Recargar</a-breadcrumb-item>
      </a-breadcrumb>

      <a-page-header
        style="border-bottom: 1px solid rgb(235, 237, 240); margin-bottom: 16px"
        title="Recargar Billetera"
      />

      <a-form :form="form" @submit="handleSubmit">
        <a-row :gutter="[16,16]" type="flex" justify="space-around">
          
          <a-col :span="6">
            <a-form-item label="Documento">
              <a-input
                v-decorator="[
                  'document',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
          
          <a-col :span="6">
            <a-form-item label="Teléfono">
              <a-input
                v-decorator="[
                  'phone',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>

          <a-col :span="6">
            <a-form-item label="Monto">
              <a-input
                v-decorator="[
                  'quantity',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
         
        </a-row>
        <a-row style="text-align: center;">
            <a-button type="primary" html-type="submit"> Recargar </a-button>
        </a-row>
      </a-form>
    </a-col>
  </a-row>
</template>

<script>

export default {
  data() {
    return {
      rechargue: '',
      messageRequired: { 
        required: true, 
        message: 'Campo requerido!' 
      },
      messageRequiredMin: { 
        min: 3,
        message: 'Se requiere mas de 3 carácteres!!',
      },
      form: this.$form.createForm(this, { name: 'coordinated' }),
    }
  },
  methods: {
    openNotification(resp, type) {
      this.$notification[type]({
        message: type === "success" ? "¡ÉXITO!" : type === "error" ? "¡ALERTA!" : "¡ATENCIÓN!" ,
        description: type === "error" ? "Hubo un error al comunicar con el servidor." : resp ,
        placement: 'bottomRight',
      });
    },
    async handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) { this.rechargue = values; } 
        else { this.rechargue = false }
      });

      if (this.rechargue) { 
        const response  =  await this.$axios.$post('http://local-epayco/resttransaction/rechargeBalance', this.rechargue)
        try {
          if (response.code === 200) {
            this.openNotification(response.message, "success");
            this.form.resetFields();
          } else { 
            this.openNotification(response.message, "warning");
          }
        } catch (error) {
          this.openNotification(error, "error");
        }
      }
    },
  },
}
</script>
