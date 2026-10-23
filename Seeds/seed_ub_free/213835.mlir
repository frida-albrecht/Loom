module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-109> : tensor<7x5x3xi16>}> : () -> tensor<7x5x3xi16>
    %1 = "tosa.const"() <{values = dense<-75.5299987> : tensor<6x10xf32>}> : () -> tensor<6x10xf32>
    %2 = tosa.reduce_min %0 {axis = 1 : i32} : (tensor<7x5x3xi16>) -> tensor<7x1x3xi16>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<7x1x3xi16>, tensor<7x1x3xi16>) -> tensor<14x1x3xi16>
    %4 = tosa.log %1 : (tensor<6x10xf32>) -> tensor<6x10xf32>
    %cast = tensor.cast %3 : tensor<14x1x3xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %4 : tensor<6x10xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

