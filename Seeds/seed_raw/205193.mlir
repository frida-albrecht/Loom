module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<10x6x8x1xi8>}> : () -> tensor<10x6x8x1xi8>
    %1 = "tosa.const"() <{values = dense<-4> : tensor<10x1x8x1xi8>}> : () -> tensor<10x1x8x1xi8>
    %2 = "tosa.const"() <{values = dense<66.4199981> : tensor<1x10xf32>}> : () -> tensor<1x10xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<10x6x8x1xi8>, tensor<10x1x8x1xi8>) -> tensor<10x6x8x1xi8>
    %4 = tosa.arithmetic_right_shift %3, %3 {round = false} : (tensor<10x6x8x1xi8>, tensor<10x6x8x1xi8>) -> tensor<10x6x8x1xi8>
    %5 = tosa.const_shape  {values = dense<[32, 15, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.reshape %4, %5 : (tensor<10x6x8x1xi8>, !tosa.shape<3>) -> tensor<32x15x1xi8>
    %7 = tosa.sigmoid %2 : (tensor<1x10xf32>) -> tensor<1x10xf32>
    %8 = tosa.bitwise_not %6 : (tensor<32x15x1xi8>) -> tensor<32x15x1xi8>
    %9 = tosa.exp %7 : (tensor<1x10xf32>) -> tensor<1x10xf32>
    %cast = tensor.cast %8 : tensor<32x15x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<1x10xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

