module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<5x6xi8>}> : () -> tensor<5x6xi8>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<5x6xi8>) -> tensor<1x6xi8>
    %2 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %1, %2 : (tensor<1x6xi8>, !tosa.shape<2>) -> tensor<1x6xi8>
    %cast = tensor.cast %3 : tensor<1x6xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

