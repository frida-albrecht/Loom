module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.598500e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<-3.780000e+00> : tensor<64xf32>}> : () -> tensor<64xf32>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<2xf32>, tensor<64xf32>) -> tensor<66xf32>
    %3 = tosa.sub %2, %2 : (tensor<66xf32>, tensor<66xf32>) -> tensor<66xf32>
    %cast = tensor.cast %3 : tensor<66xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

