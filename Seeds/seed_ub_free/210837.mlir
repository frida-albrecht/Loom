module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.021500e+02> : tensor<2x6x3x10xf32>}> : () -> tensor<2x6x3x10xf32>
    %1 = "tosa.const"() <{values = dense<20> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<2> : tensor<i8>}> : () -> tensor<i8>
    %3 = tosa.const_shape  {values = dense<[2, 1, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %0, %3 : (tensor<2x6x3x10xf32>, !tosa.shape<4>) -> tensor<4x6x9x10xf32>
    %5 = tosa.identity %4 : (tensor<4x6x9x10xf32>) -> tensor<4x6x9x10xf32>
    %6 = tosa.logical_right_shift %1, %2 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %5 : tensor<4x6x9x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<i8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

