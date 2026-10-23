module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.555300e+02> : tensor<6x7x10xf32>}> : () -> tensor<6x7x10xf32>
    %1 = "tosa.const"() <{values = dense<18> : tensor<7x4x9xi8>}> : () -> tensor<7x4x9xi8>
    %2 = tosa.exp %0 : (tensor<6x7x10xf32>) -> tensor<6x7x10xf32>
    %3 = tosa.sub %2, %2 : (tensor<6x7x10xf32>, tensor<6x7x10xf32>) -> tensor<6x7x10xf32>
    %4 = tosa.bitwise_not %1 : (tensor<7x4x9xi8>) -> tensor<7x4x9xi8>
    %5 = tosa.const_shape  {values = dense<[60, 1, 7, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.reshape %3, %5 : (tensor<6x7x10xf32>, !tosa.shape<4>) -> tensor<60x1x7x1xf32>
    %cast = tensor.cast %4 : tensor<7x4x9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<60x1x7x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

