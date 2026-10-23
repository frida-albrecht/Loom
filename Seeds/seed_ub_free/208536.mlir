module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.639200e+02> : tensor<1x7xf32>}> : () -> tensor<1x7xf32>
    %1 = "tosa.const"() <{values = dense<-4.780000e+01> : tensor<10x7xf32>}> : () -> tensor<10x7xf32>
    %2 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<1x7xf32>, tensor<10x7xf32>) -> tensor<11x7xf32>
    %cast = tensor.cast %2 : tensor<11x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

