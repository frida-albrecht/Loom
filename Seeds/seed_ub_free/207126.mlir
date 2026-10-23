module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.826900e+02> : tensor<3x1x6x1xf32>}> : () -> tensor<3x1x6x1xf32>
    %1 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 1, 3, 2>} : (tensor<3x1x6x1xf32>) -> tensor<3x1x1x6xf32>
    %cast = tensor.cast %2 : tensor<3x1x1x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

