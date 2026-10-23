module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<0> : tensor<6x4x8x8xi8>}> : () -> tensor<6x4x8x8xi8>
    %1 = "tosa.const"() <{values = dense<-5.858000e+01> : tensor<8x9x2xf32>}> : () -> tensor<8x9x2xf32>
    %2 = tosa.identity %0 : (tensor<6x4x8x8xi8>) -> tensor<6x4x8x8xi8>
    %3 = tosa.log %1 : (tensor<8x9x2xf32>) -> tensor<8x9x2xf32>
    %4 = tosa.const_shape  {values = dense<[1, 3, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.tile %2, %4 : (tensor<6x4x8x8xi8>, !tosa.shape<4>) -> tensor<6x12x8x16xi8>
    %cast = tensor.cast %3 : tensor<8x9x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6x12x8x16xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

