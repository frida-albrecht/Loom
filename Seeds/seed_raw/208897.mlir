module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<69> : tensor<8x4x10xi16>}> : () -> tensor<8x4x10xi16>
    %1 = "tosa.const"() <{values = dense<-28> : tensor<41x4x10xi16>}> : () -> tensor<41x4x10xi16>
    %2 = "tosa.const"() <{values = dense<-119> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<-185> : tensor<i32>}> : () -> tensor<i32>
    %4 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<8x4x10xi16>, tensor<41x4x10xi16>) -> tensor<49x4x10xi16>
    %5 = tosa.bitwise_not %4 : (tensor<49x4x10xi16>) -> tensor<49x4x10xi16>
    %6 = tosa.reduce_min %5 {axis = 1 : i32} : (tensor<49x4x10xi16>) -> tensor<49x1x10xi16>
    %7 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %8 = tosa.sub %6, %6 : (tensor<49x1x10xi16>, tensor<49x1x10xi16>) -> tensor<49x1x10xi16>
    %9 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.reshape %7, %9 : (tensor<i32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %cast = tensor.cast %8 : tensor<49x1x10xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %10 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

