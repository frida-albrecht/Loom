module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.611000e+01> : tensor<3x10xf32>}> : () -> tensor<3x10xf32>
    %1 = tosa.ceil %0 : (tensor<3x10xf32>) -> tensor<3x10xf32>
    %2 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %3 = tosa.transpose %1 {perms = array<i32: 0, 1>} : (tensor<3x10xf32>) -> tensor<3x10xf32>
    %cast = tensor.cast %3 : tensor<3x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

