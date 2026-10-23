module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.543000e+02> : tensor<7x9x7xf32>}> : () -> tensor<7x9x7xf32>
    %1 = "tosa.const"() <{values = dense<12> : tensor<4x6xi8>}> : () -> tensor<4x6xi8>
    %2 = "tosa.const"() <{values = dense<-9> : tensor<1x6xi8>}> : () -> tensor<1x6xi8>
    %3 = tosa.log %0 : (tensor<7x9x7xf32>) -> tensor<7x9x7xf32>
    %4 = tosa.log %3 : (tensor<7x9x7xf32>) -> tensor<7x9x7xf32>
    %5 = tosa.bitwise_xor %1, %2 : (tensor<4x6xi8>, tensor<1x6xi8>) -> tensor<4x6xi8>
    %6 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.tile %5, %6 : (tensor<4x6xi8>, !tosa.shape<2>) -> tensor<4x6xi8>
    %8 = tosa.bitwise_not %7 : (tensor<4x6xi8>) -> tensor<4x6xi8>
    %cast = tensor.cast %4 : tensor<7x9x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<4x6xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

