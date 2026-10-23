module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<64.1999969> : tensor<3xf32>}> : () -> tensor<3xf32>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<3xf32>) -> tensor<1xf32>
    %2 = tosa.pow %1, %1 : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %3 = tosa.identity %2 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

