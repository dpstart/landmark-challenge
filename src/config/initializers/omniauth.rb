Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '785107930712-dtokjmqs51l3fos5gqalo64u9nsn4i4q.apps.googleusercontent.com', 'lcexGVm2R5ERTLCzt0xUX1js'
  provider :github, '571bca54272a766d87c9', '2aadeb57edf862263713d3c401e70305d0897007'
end
