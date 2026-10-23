module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<7xi8>}> : () -> tensor<7xi8>
    %1 = "tosa.const"() <{values = dense<17> : tensor<7xi8>}> : () -> tensor<7xi8>
    %2 = tosa.add %0, %1 : (tensor<7xi8>, tensor<7xi8>) -> tensor<7xi8>
    %3 = tosa.bitwise_not %2 : (tensor<7xi8>) -> tensor<7xi8>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<7xi8>) -> tensor<1xi8>
    %5 = tosa.reverse %4 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %6 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %7 = tosa.tile %5, %6 : (tensor<1xi8>, !tosa.shape<1>) -> tensor<1xi8>
    %8 = tosa.const_shape  {values = dense<1> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.reshape %7, %8 : (tensor<1xi8>, !tosa.shape<4>) -> tensor<1x1x1x1xi8>
    %cast = tensor.cast %9 : tensor<1x1x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

