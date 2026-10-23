module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<6.326000e+01> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "tosa.const"() <{values = dense<7.302000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.pow %0, %1 : (tensor<8xf32>, tensor<1xf32>) -> tensor<8xf32>
    %3 = tosa.reduce_product %2 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

