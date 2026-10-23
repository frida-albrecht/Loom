module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-63.4199981> : tensor<9x2xf32>}> : () -> tensor<9x2xf32>
    %1 = tosa.rsqrt %0 : (tensor<9x2xf32>) -> tensor<9x2xf32>
    %2 = tosa.reverse %1 {axis = 1 : i32} : (tensor<9x2xf32>) -> tensor<9x2xf32>
    %3 = tosa.tanh %2 : (tensor<9x2xf32>) -> tensor<9x2xf32>
    %cast = tensor.cast %3 : tensor<9x2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

