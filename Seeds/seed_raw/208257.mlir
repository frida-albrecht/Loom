module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.434000e+01> : tensor<10xf32>}> : () -> tensor<10xf32>
    %1 = "tosa.const"() <{values = dense<-1.646100e+02> : tensor<10xf32>}> : () -> tensor<10xf32>
    %2 = tosa.minimum %0, %1 : (tensor<10xf32>, tensor<10xf32>) -> tensor<10xf32>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<10xf32>) -> tensor<10xf32>
    %cast = tensor.cast %3 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

