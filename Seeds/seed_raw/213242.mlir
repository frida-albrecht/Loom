module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.249900e+02> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = tosa.tanh %0 : (tensor<6xf32>) -> tensor<6xf32>
    %2 = tosa.tanh %1 : (tensor<6xf32>) -> tensor<6xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0>} : (tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %4 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

