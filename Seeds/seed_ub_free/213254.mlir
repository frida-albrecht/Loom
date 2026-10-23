module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<2xi8>}> : () -> tensor<2xi8>
    %1 = tosa.const_shape  {values = dense<[2, 1, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<2xi8>, !tosa.shape<3>) -> tensor<2x1x1xi8>
    %3 = tosa.identity %2 : (tensor<2x1x1xi8>) -> tensor<2x1x1xi8>
    %4 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %5 = tosa.transpose %3 {perms = array<i32: 0, 1, 2>} : (tensor<2x1x1xi8>) -> tensor<2x1x1xi8>
    %cast = tensor.cast %5 : tensor<2x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

