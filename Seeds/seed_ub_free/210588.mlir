module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<5x1x7xi8>}> : () -> tensor<5x1x7xi8>
    %1 = tosa.bitwise_not %0 : (tensor<5x1x7xi8>) -> tensor<5x1x7xi8>
    %2 = tosa.add %1, %1 : (tensor<5x1x7xi8>, tensor<5x1x7xi8>) -> tensor<5x1x7xi8>
    %3 = tosa.const_shape  {values = dense<[7, 1, 1, 5]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.reshape %2, %3 : (tensor<5x1x7xi8>, !tosa.shape<4>) -> tensor<7x1x1x5xi8>
    %cast = tensor.cast %4 : tensor<7x1x1x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

