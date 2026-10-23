module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.608300e+02> : tensor<7x7x2x9xf32>}> : () -> tensor<7x7x2x9xf32>
    %1 = "tosa.const"() <{values = dense<-42> : tensor<3x10xi32>}> : () -> tensor<3x10xi32>
    %2 = "tosa.const"() <{values = dense<-51> : tensor<3x1xi32>}> : () -> tensor<3x1xi32>
    %3 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %4 = tosa.transpose %0 {perms = array<i32: 0, 3, 1, 2>} : (tensor<7x7x2x9xf32>) -> tensor<7x9x7x2xf32>
    %5 = tosa.logical_left_shift %1, %2 : (tensor<3x10xi32>, tensor<3x1xi32>) -> tensor<3x10xi32>
    %6 = tosa.exp %4 : (tensor<7x9x7x2xf32>) -> tensor<7x9x7x2xf32>
    %cast = tensor.cast %5 : tensor<3x10xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<7x9x7x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

