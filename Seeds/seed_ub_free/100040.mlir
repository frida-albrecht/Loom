module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.155000e+02> : tensor<123x125xf32>}> : () -> tensor<123x125xf32>
    %1 = "tosa.const"() <{values = dense<-8.649000e+01> : tensor<125x124xf32>}> : () -> tensor<125x124xf32>
    %2 = "tosa.const"() <{values = dense<-1.182100e+02> : tensor<123x124xf32>}> : () -> tensor<123x124xf32>
    %3 = linalg.matmul ins(%0, %1 : tensor<123x125xf32>, tensor<125x124xf32>) outs(%2 : tensor<123x124xf32>) -> tensor<123x124xf32>
    %cast = tensor.cast %3 : tensor<123x124xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

