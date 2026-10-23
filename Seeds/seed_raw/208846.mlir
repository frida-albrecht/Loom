module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.438800e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = tosa.sigmoid %0 : (tensor<8xf32>) -> tensor<8xf32>
    %2 = tosa.tanh %1 : (tensor<8xf32>) -> tensor<8xf32>
    %cast = tensor.cast %2 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

