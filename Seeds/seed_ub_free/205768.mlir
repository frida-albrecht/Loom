module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.138000e+01> : tensor<6x2xf32>}> : () -> tensor<6x2xf32>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<6x2xf32>) -> tensor<1x2xf32>
    %2 = tosa.floor %1 : (tensor<1x2xf32>) -> tensor<1x2xf32>
    %3 = tosa.reciprocal %2 : (tensor<1x2xf32>) -> tensor<1x2xf32>
    %cast = tensor.cast %3 : tensor<1x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

