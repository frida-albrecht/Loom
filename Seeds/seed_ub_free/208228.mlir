module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<i8>}> : () -> tensor<i8>
    %1 = tosa.const_shape  {values = dense<1> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<i8>, !tosa.shape<3>) -> tensor<1x1x1xi8>
    %3 = tosa.reduce_product %2 {axis = 1 : i32} : (tensor<1x1x1xi8>) -> tensor<1x1x1xi8>
    %cast = tensor.cast %3 : tensor<1x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

